// const initImgOnScroll = () => {
var scroll = $(window).scrollTop();
console.log(scroll)
//   $(document).on("scroll", function(){
//     // Change 100 to whatever suits you
//     console.log("coucou toi")
//     const img = document.querySelector(".img-wrapper")
//       img.querySelectorAll(".img-wrapper").forEach((imgWrap) => {
//         imgWrap.classList.remove("img-wrapper-small")
//         navLink.classList.add("img-wrapper-full")
//     })
//   });
// };

function initImgOnScroll() {
  var img = document.querySelector(".img-wrapper");
  img.classList.remove("img-wrapper-small");
  img.classList.add("img-wrapper-full");
};

export { initImgOnScroll }
