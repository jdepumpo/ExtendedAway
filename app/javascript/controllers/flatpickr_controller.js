import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import Swiper, { Navigation, Pagination } from 'swiper';

export default class extends Controller {

  static targets = ["calendarInput"]

  connect() {
    new flatpickr(this.calendarInputTarget, {
      inline: true,
      // more options available on the documentation!
    });

    this.#getSwiper()
  }

  highlightTask() {
    const searchDate = this.calendarInputTarget.value
    console.log(searchDate)
    const swiperCard = document.getElementById(searchDate)
    console.log(swiperCard)
    const slideIndex = swiperCard.dataset.slideIndex
    console.log(slideIndex)
    this.swiper.slideTo(parseInt(slideIndex) + 1, 500, true)

  }

  #getSwiper() {
      this.swiper = new Swiper('.swiper', {
      // configure Swiper to use modules
      modules: [Navigation, Pagination],
        // If we need pagination
      pagination: {
        el: '.swiper-pagination',
      },

      // Navigation arrows
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },

    });
  }
}
