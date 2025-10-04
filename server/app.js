const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const mysql = require("mysql2");
// const cron = require('node-cron');

const app = express();
const PORT = process.env.PORT || 3000;
app.use('/public', express.static('public'));

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Logging middleware
app.use((req, res, next) => {
  console.log(`Incoming Request: ${req.method} ${req.url}`);
  console.log("Request Body:", req.body);
  next();
});

// MySQL connection
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "", // your MySQL root password
  database: "userdb",
});

db.connect((err) => {
  if (err) {
    console.error("MySQL connection error:", err);
    return;
  }
  console.log("Connected to MySQL database");
});

// ---------------------------login/register-------------------------
// Login endpoint
app.post("/login", async (req, res) => {
  const { username, password } = req.body;
  const query = "SELECT * FROM users WHERE username = ?";

  db.query(query, [username], async (err, results) => {
    if (err || results.length === 0) {
      console.error("Login error or user not found:", err);
      return res.status(401).send("Invalid username or password");
    }

    const user = results[0];
    if (await bcrypt.compare(password, user.password)) {
      // Include userId in the token payload
      const token = jwt.sign({ username: user.username, userId: user.user_id }, "secretKey");
      res.json({ token });
    } else {
      res.status(401).send("Invalid username or password");
    }
  });
});
// Register endpoint
app.post("/register", async (req, res) => {
  const { username, email, password } = req.body;

  if (!username || !email || !password) {
    return res.status(400).send("Missing fields");
  }
  // Check if the username already exists
  const [existingUser] = await db
    .promise()
    .query("SELECT * FROM users WHERE username = ?", [username]);

  if (existingUser.length > 0) {
    return res.status(409).send("Username already exists"); // 409 Conflict
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    await db
      .promise()
      .query("INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, 1)", [
        username,
        email,
        hashedPassword,
      ]);
    res.status(201).send("User registered");
  } catch (error) {
    console.error("Error during registration:", error);
    res.status(500).send("Internal Server Error");
  }
});

//--------------------------------student---------------------------
// browse get 1 room
app.get("/rooms/browse/:id", function (req, res) {
  const bookid = req.params.id;
  const sql = "SELECT * FROM rooms WHERE room_id=?";
  db.query(sql, [bookid], function (err, results) {
    if (err) {
      // console.log(sql);
      console.error(err);
      return res.status(500).send("Database server error");
    }
    res.json(results);
  });
});
// browse get all
app.get("/rooms/browse", function (req, res) {
  const sql = "SELECT * FROM rooms";
  db.query(sql, function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    res.json(results);
  });
});

// request status student
app.post("/request", function (req, res) {
  let user_id = req.body.user_id;
  let room_id = req.body.room_id;
  let slot_id = req.body.slot_id;

  // Create an empty object to hold the room status data
  let roomData = {};

  // Set the room's status to "booked" (status code 2)
  roomData[slot_id] = 2; // Status 2 means booked

  // Get the current date to check bookings for today
  let currentDate = new Date().toISOString().split("T")[0];

  // Check if the user already has a booking for today
  const checkBookingSql = `
    SELECT * FROM bookings 
    WHERE user_id = ? AND DATE(booking_date) = ?
  `;

  db.query(checkBookingSql, [user_id, currentDate], function (err, results) {
    if (err) {
      console.error("Error checking booking:", err);
      return res.status(500).send("Database server error while checking booking.");
    }

    if (results.length > 0) {
      // If a booking already exists for the user today, reject the request
      return res.status(400).send("You can only book one slot per day.");
    }

    // Proceed with the booking if no existing booking is found
    const insertBookingSql = `
      INSERT INTO bookings (user_id, room_id, slot_id, status, booking_date) 
      VALUES (?, ?, ?, 2, ?)
    `;

    db.query(insertBookingSql, [user_id, room_id, slot_id, currentDate], function (err, results) {
      if (err) {
        console.error("Error inserting booking:", err);
        return res.status(500).send("Database server error while inserting booking.");
      }

      // Update the room's status for the booked slot
      const updateRoomSql = `
        UPDATE rooms 
        SET ${slot_id} = 2 
        WHERE room_id = ?
      `;

      db.query(updateRoomSql, [room_id], function (err, results) {
        if (err) {
          console.error("Error updating room status:", err);
          return res.status(500).send("Database server error while updating room status.");
        }

        // Successfully booked and updated the room status
        res.send("Booking successful!");
      });
    });
  });
});


// history
app.get("/student/history", (req, res) => {
  const { role, userId } = req.query;

  console.log("Received role:", role);
  console.log("Received userId:", userId);

  if (role !== "1") {
    return res.status(403).send("Access denied: only students can view history");
  }

  const query = `
      SELECT 
          users.username, 
          users.role, 
          bookings.slot_id, 
          rooms.room_name, 
          bookings.approved_by, 
          bookings.status,
          rooms.size
      FROM bookings
      JOIN users ON bookings.user_id = users.user_id
      JOIN rooms ON bookings.room_id = rooms.room_id
      WHERE bookings.user_id = ?
  `;

  db.query(query, [userId], (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res.status(500).send("Database error: " + err.message);
    }

    console.log("Query results:", results);
    res.json(results); // Send the result back in JSON format
  });
});


// -----------------------------------------staff--------------------------
// add
app.post("/addrooms", function (req, res) {
  const { room_name, slot_1, slot_2, slot_3, slot_4, img, size } = req.body;

  const sizeImages = {
    1: "TableSmallRoom.png",
    2: "TableMediumRoom.png",
    3: "TableLargeRoom.png",
  };

  // Use provided image or fallback to size-based default
  const roomImage = img || sizeImages[size];

  const sql =
    "INSERT INTO rooms (room_name, slot_1, slot_2, slot_3, slot_4, img, size) VALUES (?, ?, ?, ?, ?, ?, ?)";
  db.query(
    sql,
    [
      room_name,
      slot_1 || 1,
      slot_2 || 1,
      slot_3 || 1,
      slot_4 || 1,
      roomImage,
      size,
    ],
    function (err, results) {
      if (err) {
        console.error(err);
        return res.status(500).send("Database server error");
      }
      res.status(201).json({
        message: "Room added successfully",
        room_id: results.insertId,
      });
    }
  );
});


// edit
app.post('/update-room-details', (req, res) => {
  const { room_id, room_name, size, img, action } = req.body;

  const sizeImages = {
    1: "TableSmallRoom.png",
    2: "TableMediumRoom.png",
    3: "TableLargeRoom.png",
  };

  if (!room_id) {
    return res.status(400).json({ error: 'room_id is required.' });
  }

  const fetchRoomQuery = `SELECT room_name, size, img, slot_1, slot_2, slot_3, slot_4 FROM rooms WHERE room_id = ?`;
  db.query(fetchRoomQuery, [room_id], (err, rows) => {
    if (err) {
      console.error('Error fetching room details:', err);
      return res.status(500).json({ error: 'Database error' });
    }

    if (rows.length === 0) {
      return res.status(404).json({ error: 'Room not found.' });
    }

    const currentRoom = rows[0];
    const updatedRoomName = room_name || currentRoom.room_name;
    const updatedSize = size || currentRoom.size;
    const updatedImage = img || sizeImages[updatedSize];

    const updateRoomQuery = `UPDATE rooms SET room_name = ?, size = ?, img = ? WHERE room_id = ?`;
    db.query(updateRoomQuery, [updatedRoomName, updatedSize, updatedImage, room_id], (err) => {
      if (err) {
        console.error('Error updating room:', err.message);
        return res.status(500).json({ error: 'Failed to update room details' });
      }

      if (!action) {
        return res.status(200).json({ message: 'Room details updated successfully.' });
      }

      const slots = [currentRoom.slot_1, currentRoom.slot_2, currentRoom.slot_3, currentRoom.slot_4];
      const disableSlotsQuery = `UPDATE rooms SET slot_1 = 3, slot_2 = 3, slot_3 = 3, slot_4 = 3 WHERE room_id = ?`;
      const enableSlotsQuery = `UPDATE rooms SET slot_1 = 1, slot_2 = 1, slot_3 = 1, slot_4 = 1 WHERE room_id = ?`;

      if (action === 'disable' && !slots.every(slot => slot === 1)) {
        return res.status(400).json({ error: 'Cannot disable slots as not all slots are currently free (1).' });
      }

      if (action === 'enable' && !slots.every(slot => slot === 3)) {
        return res.status(400).json({ error: 'Cannot enable slots as not all slots are currently disabled (3).' });
      }

      const query = action === 'enable' ? enableSlotsQuery : disableSlotsQuery;
      db.query(query, [room_id], (err) => {
        if (err) {
          console.error(`Error ${action} slots:`, err.message);
          return res.status(500).json({ error: `Failed to ${action} slots` });
        }

        res.status(200).json({ message: `Room details updated and slots ${action}d successfully.` });
      });
    });
  });
});





// dashboard
app.get("/staff/dashboard", function (req, res) {
  const sql = `
    SELECT 
      SUM(slot_1 = 1) + SUM(slot_2 = 1) + SUM(slot_3 = 1) + SUM(slot_4 = 1) AS total_free,
      SUM(slot_1 = 2) + SUM(slot_2 = 2) + SUM(slot_3 = 2) + SUM(slot_4 = 2) AS total_pending,
      SUM(slot_1 = 3) + SUM(slot_2 = 3) + SUM(slot_3 = 3) + SUM(slot_4 = 3) AS total_disabled,
      SUM(slot_1 = 4) + SUM(slot_2 = 4) + SUM(slot_3 = 4) + SUM(slot_4 = 4) AS total_reserved,
      COUNT(*) AS total_rooms,
      (SUM(slot_1 IS NOT NULL) + SUM(slot_2 IS NOT NULL) + SUM(slot_3 IS NOT NULL) + SUM(slot_4 IS NOT NULL)) AS total_slots
    FROM rooms;
  `;
  db.query(sql, function (err, results) {
    if (err) {
      console.error("Database query error:", err);
      return res.status(500).json({ error: "Database query error" });
    }
    res.json({
      total_free: results[0].total_free,
      total_pending: results[0].total_pending,
      total_reserved: results[0].total_reserved,
      total_disabled: results[0].total_disabled,
      total_rooms: results[0].total_rooms,
      total_slots: results[0].total_slots,
    });
  });
});

// history
//staff history
app.get("/staff/history", (req, res) => {
  const query = `
  SELECT 
      students.username AS student_username,  -- Fetch student's username
      approvers.username AS approver_username, -- Fetch approver's username
      bookings.slot_id, 
      rooms.room_name, 
      bookings.approved_by, 
      bookings.status,
      rooms.size
  FROM bookings
  JOIN users AS students ON bookings.user_id = students.user_id -- Map user_id to student
  LEFT JOIN users AS approvers ON bookings.approved_by = approvers.user_id -- Map approved_by to approver (LEFT JOIN to handle null approvers)
  JOIN rooms ON bookings.room_id = rooms.room_id
  `;

  db.query(query, (err, results) => {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).json({ message: "Internal server error" });
    }
    if (results.length === 0) {
      return res.status(404).json({ message: "No booking history found" });
    }
    res.json(results);
  });
});




// --------------------------------Approver--------------------------------
// approve or disapprove
// Approve or disapprove booking
app.put("/approver/approve", (req, res) => {
  const { bookingId, approverId, approve, slot_id, room_id } = req.body;

  // Validate required parameters
  if (!bookingId || !slot_id || !room_id || !approverId) {
    return res.status(400).json({ message: "Missing required parameters" });
  }

  const status = approve ? 1 : 3;

  // Check if the approverId exists in the 'users' table
  const checkApproverQuery = `SELECT * FROM users WHERE user_id = ?`;
  db.query(checkApproverQuery, [approverId], (err, results) => {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).send("Database error");
    }

    // If the approver doesn't exist, return an error
    if (results.length === 0) {
      return res.status(400).json({ message: "Approver does not exist" });
    }

    // If the approver exists, proceed with the update
    const queryUpdateBooking = `
      UPDATE bookings 
      SET status = ?, approved_by = ? 
      WHERE booking_id = ?
    `;

    // Start a transaction to ensure data consistency
    db.beginTransaction((err) => {
      if (err) {
        return res.status(500).send("Database transaction error");
      }

      // Update the booking status and approved_by
      db.query(
        queryUpdateBooking,
        [status, approverId, bookingId],
        (err, result) => {
          if (err) {
            return db.rollback(() => {
              console.error("Database error:", err);
              return res.status(500).send("Database server error");
            });
          }

          let roomData = {};
          if (approve) {
            roomData[slot_id] = 4; // Approve the slot
          } else {
            roomData[slot_id] = 1; // Disapprove the slot
          }

          // Validate that room_id is provided
          if (!room_id) {
            return res.status(400).json({ message: "Room ID is required" });
          }

          // Update the room data
          db.query(
            "UPDATE rooms SET ? WHERE room_id = ?",
            [roomData, room_id],
            function (err, results) {
              if (err) {
                return db.rollback(() => {
                  console.error("Room update error:", err);
                  return res.status(500).send("Database server error");
                });
              }

              // Commit the transaction after both updates
              db.commit((err) => {
                if (err) {
                  return db.rollback(() => {
                    console.error("Commit error:", err);
                    return res.status(500).send("Database commit error");
                  });
                }

                res.json({
                  message: approve
                    ? "Booking approved successfully"
                    : "Booking disapproved successfully",
                });
              });
            }
          );
        }
      );
    });
  });
});



//approver history
app.get("/approver/history", (req, res) => {
  const {approved_by } = req.query;

  // SQL Query
  const query = `
  SELECT 
      students.username AS student_username,  -- Fetch student's username
      approvers.username AS approver_username, -- Fetch approver's username
      bookings.slot_id, 
      rooms.room_name, 
      bookings.approved_by, 
      bookings.status,
      rooms.size
  FROM bookings
  JOIN users AS students ON bookings.user_id = students.user_id -- Map user_id to student
  JOIN users AS approvers ON bookings.approved_by = approvers.user_id -- Map approved_by to approver
  JOIN rooms ON bookings.room_id = rooms.room_id
  WHERE bookings.approved_by = ?
`;

  // Execute Query
  db.query(query, [approved_by], (err, results) => {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).send("Database error");
    }

    // Return JSON response
    res.json({
      success: true,
      data: results,
    });
  });
});


// Define the route to get pending bookings
app.get("/bookings", (req, res) => {
  const query = `
    SELECT 
      b.booking_id, 
      b.room_id, 
      b.status, 
      b.user_id, 
      u.username AS user_username, -- Fetch the username of the user
      b.slot_id, 
      r.size AS room_size, 
      r.room_name
    FROM bookings b
    JOIN rooms r ON b.room_id = r.room_id
    JOIN users u ON b.user_id = u.user_id -- Join users table to get username
    WHERE b.status = 2
  `;

  db.query(query, (err, results) => {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).send("Database server error");
    }

    // Send booking data in JSON format with the username
    res.json(results);
  });
});


// GET /user/profile - Retrieve user's profile
app.get("/user/profile", authenticateToken, (req, res) => {
  // Check if the username is extracted correctly from the token
  const username = req.user?.username;
  if (!username) {
    console.error("Username not found in token");
    return res.status(400).send("Invalid token: username missing");
  }

  console.log("Fetching profile for username:", username);

  const query = "SELECT username, role FROM users WHERE username = ?";
  db.query(query, [username], (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res.status(500).send("Database error");
    }
    if (results.length === 0) {
      console.error("User not found in database:", username);
      return res.status(404).send("User not found");
    }

    const user = results[0];
    res.json({
      username: user.username,
      role: user.role.toString(), // Convert role to string if needed
    });
  });
});


// -------run port--------
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});

function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    console.error("No token provided");
    return res.status(401).send("Access denied: No token provided");
  }

  jwt.verify(token, "secretKey", (err, user) => {
    if (err) {
      console.error("Token verification failed:", err);
      return res.status(403).send("Access denied: Invalid token");
    }
    req.user = user;
    next();
  });
}