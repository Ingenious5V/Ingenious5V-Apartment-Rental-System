// html/script.js
document.addEventListener('DOMContentLoaded', () => {
    console.log('NUI loaded');

    window.addEventListener('message', (event) => {
        const data = event.data;
        if (data.action === 'openApartmentMenu') {
            openApartmentMenu(data.apartments);
        }
    });
});

function openApartmentMenu(apartments) {
    const menu = document.getElementById('apartment-menu');
    menu.innerHTML = ''; // Clear existing menu items

    apartments.forEach(apartment => {
        const item = document.createElement('div');
        item.className = 'menu-item';
        item.innerText = `${apartment.name} - $${apartment.price}`;
        menu.appendChild(item);
    });

    menu.style.display = 'block';
}
