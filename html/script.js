document.addEventListener('DOMContentLoaded', function() {
    const ipad = document.getElementById('ipad');
    const closeBtn = document.getElementById('close-btn');
    const prevBtn = document.getElementById('prev-btn');
    const nextBtn = document.getElementById('next-btn');
    const apartmentName = document.getElementById('apartment-name');
    const apartmentPrice = document.getElementById('apartment-price');
    const apartmentImage = document.getElementById('apartment-image');
    const interiorImage = document.getElementById('interior-image');

    // Example data
    const apartments = [
        {
            name: 'Apartment 1',
            price: '$1000/month',
            image: 'images/default_apartment.jpg',
            interior: 'images/default_interior.jpg'
        },
        {
            name: 'Apartment 2',
            price: '$1200/month',
            image: 'images/default_apartment.jpg',
            interior: 'images/default_interior.jpg'
        }
    ];

    let currentIndex = 0;

    function updateApartmentInfo(index) {
        const apartment = apartments[index];
        apartmentName.textContent = apartment.name;
        apartmentPrice.textContent = apartment.price;
        apartmentImage.src = apartment.image;
        interiorImage.src = apartment.interior;
    }

    prevBtn.addEventListener('click', function() {
        currentIndex = (currentIndex > 0) ? currentIndex - 1 : apartments.length - 1;
        updateApartmentInfo(currentIndex);
    });

    nextBtn.addEventListener('click', function() {
        currentIndex = (currentIndex < apartments.length - 1) ? currentIndex + 1 : 0;
        updateApartmentInfo(currentIndex);
    });

    closeBtn.addEventListener('click', function() {
        ipad.style.display = 'none';
    });

    // Initialize with the first apartment
    updateApartmentInfo(currentIndex);
});
