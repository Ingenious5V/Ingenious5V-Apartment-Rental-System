// html/script.js
document.addEventListener('DOMContentLoaded', () => {
    console.log('NUI loaded');

    window.addEventListener('message', (event) => {
        const data = event.data;
        if (data.action === 'openApartmentMenu') {
            openApartmentMenu(data.apartments);
        }
    });

    let currentApartmentIndex = 0;
    let apartments = [];

    function openApartmentMenu(apartmentList) {
        apartments = apartmentList;
        currentApartmentIndex = 0;
        displayApartmentInfo();
        document.getElementById('ipad').style.display = 'block';
    }

    function displayApartmentInfo() {
        const apartment = apartments[currentApartmentIndex];
        document.getElementById('apartment-name').innerText = apartment.name;
        document.getElementById('apartment-price').innerText = `Price: $${apartment.price}`;
        document.getElementById('apartment-image').src = apartment.image;
        document.getElementById('interior-image').src = apartment.interiorImage;
    }

    document.getElementById('prev-btn').addEventListener('click', () => {
        if (currentApartmentIndex > 0) {
            currentApartmentIndex--;
            displayApartmentInfo();
        }
    });

    document.getElementById('next-btn').addEventListener('click', () => {
        if (currentApartmentIndex < apartments.length - 1) {
            currentApartmentIndex++;
            displayApartmentInfo();
        }
    });
});
