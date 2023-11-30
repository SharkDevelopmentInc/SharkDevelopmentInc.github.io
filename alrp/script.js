document.addEventListener('DOMContentLoaded', function () {
    // Fetch directory content
    fetchDirectoryContent();
});

function fetchDirectoryContent() {
    // Update the path to match your desired directory
    const directoryPath = './get_directory.php';

    // Fetch the directory content
    fetch(directoryPath)
        .then(response => response.json())
        .then(displayDirectoryList)
        .catch(error => console.error('Error fetching directory content:', error));
}

function displayDirectoryList(data) {
    const directoryList = document.getElementById('directory-list');

    // Create an unordered list
    const ul = document.createElement('ul');

    // Append list items to the unordered list
    data.forEach(item => {
        const li = document.createElement('li');
        li.textContent = item;
        ul.appendChild(li);
    });

    // Append the unordered list to the directoryList div
    directoryList.appendChild(ul);
}
