document.addEventListener('DOMContentLoaded', function () {
    // Fetch directory content
    fetchDirectoryContent();
});

function fetchDirectoryContent() {
    // Update the path to match your desired directory
    const directoryPath = './transcript/';

    // Fetch the directory content
    fetch(directoryPath)
        .then(response => response.text())
        .then(parseDirectoryContent)
        .catch(error => console.error('Error fetching directory content:', error));
}

function parseDirectoryContent(content) {
    const parser = new DOMParser();
    const xmlDoc = parser.parseFromString(content, 'text/html');

    // Get all anchor elements (links) in the directory content
    const links = xmlDoc.querySelectorAll('a');

    // Filter out parent directory link and current directory link
    const validLinks = Array.from(links).filter(link =>
        link.getAttribute('href') !== '../' &&
        link.getAttribute('href') !== './'
    );

    // Display the directory content
    displayDirectoryList(validLinks);
}

function displayDirectoryList(links) {
    const directoryList = document.getElementById('directory-list');

    // Create an unordered list
    const ul = document.createElement('ul');

    // Append list items to the unordered list
    links.forEach(link => {
        const li = document.createElement('li');
        li.textContent = link.getAttribute('href');
        ul.appendChild(li);
    });

    // Append the unordered list to the directoryList div
    directoryList.appendChild(ul);
}
