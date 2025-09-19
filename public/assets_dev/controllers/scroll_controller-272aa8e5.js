import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["messages"];

    connect(){
        console.log("Connected");
        this.resetScrollPosition();

        this.observer = new MutationObserver(() => this.resetScrollPosition());
        this.observer.observe(this.messagesTarget, { childList: true, subtree: true });
    }

    disconnect(){
        console.log("Disconnected");
        if (this.observer) this.observer.disconnect();
    }

    resetScrollPosition(){
        this.messagesTarget.scrollTo({
            top: this.messagesTarget.scrollHeight,
            behavior: "smooth"
        })
    }
}