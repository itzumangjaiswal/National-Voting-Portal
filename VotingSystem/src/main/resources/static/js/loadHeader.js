
// Function to load header.html into the specified element
import {COLORS} from "../colors/data.js";

function loadHeader() {
    console.log("Head Loader")

    fetch('header.html')
        .then(response => response.text())
        .then(data => {
            document.getElementById('header').innerHTML = data;
            document.body.style.removeProperty('color');
            updateDefaultStyles();
            attachHeaderEvents();
        })
        .catch(error => console.error('Error loading Header:', error.message))
}

function updateDefaultStyles() {
    // Apply header background color
    const header = document.querySelector('header');
    if (header) {
        header.style.backgroundColor = COLORS['header-bg-color'];

        // Apply body background color
        document.body.style.backgroundColor = COLORS['body-bg-light'];

        // Apply font color
        document.body.style.color = COLORS['font-color'];
    }


}

// Function to attach event listeners to header buttons
// Function to attach event listeners to header buttons
function attachHeaderEvents() {
    const increaseFontSizeButton = document.getElementById('increaseFontSize');
    const decreaseFontSizeButton = document.getElementById('decreaseFontSize');
    const resetFontSizeButton = document.getElementById('resetFontSize');
    const toggleModeButton = document.getElementById('toggleMode');

    let currentFontSize = 16;
    let isDarkMode = false;

    // Helper function to update font size for body, table, and iframe
    function updateFontSize(newFontSize) {
        document.body.style.fontSize = `${newFontSize}px`;

        // Apply the font size to all tables
        const tables = document.querySelectorAll('table');
        tables.forEach(table => {
            table.style.fontSize = `${newFontSize}px`;
        });

        // Apply the font size to all iframes' body
        const iframes = document.querySelectorAll('iframe');
        iframes.forEach(iframe => {
            try {
                iframe.contentDocument.body.style.fontSize = `${newFontSize}px`;
            } catch (error) {
                console.log("Error accessing iframe content:", error);
            }
        });
    }

    // Helper function to toggle dark/light mode for body, table, and iframe
    function toggleBackground(isDarkMode) {
        const backgroundColor = isDarkMode ? COLORS['body-bg-dark'] : COLORS['body-bg-light'];
        const fontColor = isDarkMode ? COLORS['font-in-dark-mode'] : COLORS['font-in-light-mode'];

        document.body.style.backgroundColor = backgroundColor;

        // Apply the background color to all tables
        const tables = document.querySelectorAll('table');
        tables.forEach(table => {
            const tableElements = table.querySelectorAll('td, tr, tbody, th');
            tableElements.forEach(element => {
                element.style.backgroundColor = backgroundColor;
                element.style.color = fontColor;
            });
        });



        // Apply the background color to all iframes' body
        const iframes = document.querySelectorAll('iframe');
        iframes.forEach(iframe => {
            try {
                iframe.contentDocument.body.style.backgroundColor = backgroundColor;
                iframe.contentDocument.body.style.color = fontColor;
            } catch (error) {
                console.log("Error accessing iframe content:", error);
            }
        });
    }


    // Event listener for increasing font size
    increaseFontSizeButton.addEventListener('click', () => {
        if (currentFontSize <= 34) {
            currentFontSize += 2;
            updateFontSize(currentFontSize);
        }
    });

    // Event listener for resetting font size
    resetFontSizeButton.addEventListener('click', () => {
        currentFontSize = 16;
        updateFontSize(currentFontSize);
    });

    // Event listener for decreasing font size
    decreaseFontSizeButton.addEventListener('click', () => {
        if (currentFontSize > 10) {
            currentFontSize -= 2;
            updateFontSize(currentFontSize);
        }
    });

    // Event listener for toggling dark mode
    toggleModeButton.addEventListener('click', () => {
        isDarkMode = !isDarkMode;
        toggleBackground(isDarkMode);
        // updateFontColorForAllTags(isDarkMode)

        if (isDarkMode) {
            toggleModeButton.classList.add('rotate-180-plus');
            toggleModeButton.classList.remove('rotate-180-minus');
        } else {
            toggleModeButton.classList.add('rotate-180-minus');
            toggleModeButton.classList.remove('rotate-180-plus');
        }
    });
}

export function jspHeaderLoader(){
    updateDefaultStyles();
    attachHeaderEvents();
}


// Load the header when the page loads
document.addEventListener('DOMContentLoaded', loadHeader);
