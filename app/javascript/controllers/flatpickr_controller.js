import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import Swiper, { Navigation, Pagination } from 'swiper';

export default class extends Controller {

  static targets = ["calendarInput"]

  connect() {
    if (!document.querySelector(".flatpickr-calendar")) {
    new flatpickr(this.calendarInputTarget, {
      inline: true,
      minDate: this.element.dataset.startDate,
      maxDate: this.element.dataset.endDate
      // more options available on the documentation!
    });
  }
    this.#getSwiper()
  }



  highlightTask() {
    const searchDate = this.calendarInputTarget.value
    console.log(searchDate)
    const swiperCard = document.getElementById(searchDate)
    console.log(swiperCard)
    const slideIndex = swiperCard.dataset.slideIndex
    console.log(slideIndex)
    this.swiper.slideTo(parseInt(slideIndex), 500, true)
    this.swiper.updateProgress()
    this.swiper.pagination.update()
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
