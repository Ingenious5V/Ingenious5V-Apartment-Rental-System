// html/script.js
document.addEventListener('DOMContentLoaded', () => {
    console.log('NUI loaded');

    window.addEventListener('message', (event) => {
        const data = event.data;
        if (data.action === 'openApartmentMenu') {
            openApartmentMenu(data.apartments, data.tabletWidth, data.tabletHeight, data.defaultApartmentImage, data.defaultInteriorImage);
        }
    });

    let currentApartmentIndex = 0;
    let apartments = [];
    let defaultApartmentImage = '';
    let defaultInteriorImage = '';

    function openApartmentMenu(apartmentList, tabletWidth, tabletHeight, defaultAptImage, defaultIntImage) {
        apartments = apartmentList;
        currentApartmentIndex = 0;
        defaultApartmentImage = defaultAptImage;
        defaultInteriorImage = defaultIntImage;
        displayApartmentInfo();
        document.getElementById('ipad').style.display = 'block';
        document.documentElement.style.setProperty('--tablet-width', `${tabletWidth}px`);
        document.documentElement.style.setProperty('--tablet-height', `${tabletHeight}px`);
    }

    function displayApartmentInfo() {
        const apartment = apartments[currentApartmentIndex];
        document.getElementById('apartment-name').innerText = apartment.name;
        document.getElementById('apartment-price').innerText = `Price: $${apartment.price}`;
        document.getElementById('apartment-image').src = apartment.image || defaultApartmentImage;
        document.getElementById('interior-image').src = apartment.interiorImage || defaultInteriorImage;
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

    document.getElementById('close-btn').addEventListener('click', () => {
        document.getElementById('ipad').style.display = 'none';
        fetch(`https://${GetParentResourceName()}/closeUI`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify({})
        });
    });
});
