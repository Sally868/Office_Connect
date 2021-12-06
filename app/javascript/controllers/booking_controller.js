import { Controller } from "stimulus"
import moment from 'moment'

window.moment = moment

export default class extends Controller {
  static targets = ['start', 'finish']
  static values = {
    isStartSelection: {
        type: Boolean,
        default: true
    }
  }

  initialize() {
    this.cells = this.element.querySelectorAll('td div')
    this.selectedStarttime = ""
    this.selectedFinishtime = ""
  }




  selectDateTime (event) {
    console.log("startDragSelect")
    const clickedElement = event.currentTarget
    const selectedDatetime = clickedElement.dataset.datetime
    
    if (this.isStartSelectionValue) {
        this.selectedStarttime = selectedDatetime
        this.clearAllSelected()
        // this.startTarget.value = this.selectedStarttime
        this.startTarget.value = window.moment(selectedDatetime).utc().format();

        clickedElement.classList.add('bg-green-500')
        // find startInputTarget and set value to data-datetime of the element that was just clicked
    } else {
        // find the endInputTarget and set value to data-datetime of the elemnt that was just clicked
        const dateLarger = window.moment(selectedDatetime).utc().isSameOrAfter(window.moment(this.selectedStarttime));
        if (dateLarger) {
            this.selectedFinishtime = selectedDatetime
            console.log(selectedDatetime)
            this.finishTarget.value = window.moment(selectedDatetime).utc().add(60, 'm').format();
            this.selectInBetween()
            clickedElement.classList.add('bg-green-500')
        } else {
            alert("Finish date must come after start date")
        }
    }



    this.isStartSelectionValue = !this.isStartSelectionValue
  }

  clearAllSelected() {
    this.cells.forEach((cell) => {
        cell.classList.remove('bg-green-500')
    })
  }

  selectInBetween() {
    this.cells.forEach((cell) => {
        const datetime = cell.dataset.datetime
        const isBetween = window.moment(datetime).isBetween(this.selectedStarttime, this.selectedFinishtime)
        if (isBetween) {
            cell.classList.add('bg-green-500')
        }
    })  
    

  }
}





// Add Form
// Add start and end inputs
// add data-booking-target="start" and data-booking-target="end"
// check to see (in connect() method) if this.startTarget/this.endTarget exists with console.log
// set the values of these in the selectDateTime method...
