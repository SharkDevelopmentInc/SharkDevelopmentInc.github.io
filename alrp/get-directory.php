<?php
$directory = './trancript/'; // Update the path to match your desired directory

// Get all files and directories in the specified directory
$contents = scandir($directory);

// Remove '.' and '..' from the list
$contents = array_diff($contents, array('.', '..'));

// Return the directory listing as JSON
header('Content-Type: application/json');
echo json_encode(array_values($contents));
