import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
    connect(){
    const userId = parseInt(this.element.dataset.userId)
        if(userId === window.currentUserId ){
            this.element.classList.add("mine")
        }else{
            this.element.classList.add("theirs")
        } // Ustawianie klasy dla wiadomości od użytkownika
    }
}