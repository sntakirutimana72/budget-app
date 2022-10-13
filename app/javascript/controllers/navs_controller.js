import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'side_nav', 'asc', 'desc', 'for_list', 'keyword', 'finder' ]

  connect() {
    this.disturbed = null
    const listId = this.for_listTarget.value === 'true' ? 'trans_list' : 'catego_list'
    this.listView = document.getElementById(listId)
  }

  toggle() {
    this.side_navTarget.classList.toggle('hidden')
  }

  ascend() {
    this.order(this.ascTarget, this.descTarget, 'column-reverse')
  }

  descend() {
    this.order(this.descTarget, this.ascTarget)
  }

  toggleSearch() {
    this.finderTarget.classList.toggle('hidden')
  }

  listItems() {
    // converts the listview children collection into an array
    return Array.from(this.listView.children)
  }

  itemText(item) {
    // retrieves a text content of an item
    return (
      this.for_listTarget.value === 'true' 
        ? item.querySelector('span').textContent
        : item.querySelector('a').textContent
    )
  }

  rightItem(item, text) {
    // check if the given element include the given text
    return !this.itemText(item).includes(text)
  }

  filteredList(text) {
    // returns a list of elements whose textes include the given partial text
    return this.listItems().filter(item => this.rightItem(item, text))
  }

  restoreList() {
    // removes hidden class from all list elements
    this.listItems().forEach(item => {
      if (item.classList.contains('hidden')) item.classList.remove('hidden')
    })
    this.disturbed = null
  }

  disturbList(text) {
    const filtered = this.filteredList(text)
    filtered.forEach(item => item.classList.add('hidden'))

    if (filtered.length) this.disturbed = true
  }

  lookup() {
    // invoked on search button click
    const partial = this.keywordTarget.value.trim()

    if (!partial) return
    if (this.disturbed) this.restoreList()

    this.disturbList(partial)
  }

  reset() {
    // triggered on value change
    if (!this.keywordTarget.value.trim() && this.disturbed) this.restoreList()
  }

  order(current, old, attrib = 'column') {
    old.classList.remove('filter-on')
    current.classList.add('filter-on')
    this.listView.style.flexDirection = attrib
  }
}
