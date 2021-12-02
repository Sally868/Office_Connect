import { Controller } from "stimulus"
import moment from 'moment'

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
        this.startTarget.value = moment(selectedDatetime).format("DD-MM-YYYY hh:mm");
      
        clickedElement.classList.add('bg-green-500')
        // find startInputTarget and set value to data-datetime of the element that was just clicked
    } else {
        // find the endInputTarget and set value to data-datetime of the elemnt that was just clicked
        const dateLarger = moment(selectedDatetime).isSameOrAfter(moment(this.selectedStarttime));
        if (dateLarger) {
            this.selectedFinishtime = selectedDatetime
            this.finishTarget.value = moment(selectedDatetime).format("DD-MM-YYYY hh:mm");
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
        const isBetween = moment(datetime).isBetween(this.selectedStarttime, this.selectedFinishtime)
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