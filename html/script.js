// Fetch apartments data from the server
fetch('/api/apartments')
    .then(response => response.json())
    .then(data => {
        const apartmentList = document.getElementById('apartment-list');
        data.forEach(apartment => {
            const apartmentItem = document.createElement('div');
            apartmentItem.innerHTML = `<h3>${apartment.name}</h3><p>Price: $${apartment.price}</p>`;
            apartmentList.appendChild(apartmentItem);
        });
    });
