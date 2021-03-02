const updateSeatsPrice = () => {
 if (document.getElementById("booking_seats")) {
  document.getElementById("booking_seats").addEventListener("change", () => {
    const numberOfSeats = parseInt(document.getElementById("booking_seats").value)
    const totalPrice = parseInt(document.getElementById("price_cruise").dataset.price)*numberOfSeats
    document.getElementById("btn-total").innerHTML = 'Board now for ' + totalPrice + ' $ '
  })
 } ;
}

export { updateSeatsPrice }
