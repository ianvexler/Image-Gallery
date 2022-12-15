import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    next() {
        let images = this.data.get("images")
        let images_array = images.split(",")
        let curr_image = document.getElementById("img").src;
        let image_src = curr_image.substring(curr_image.indexOf('/uploads'));
        let image_index = images_array.indexOf(image_src)

        // In case the array is finished go to the last image
        if (image_index+1 == images_array.length) {
            image_index = -1
        }

        document.getElementById("img").src=images_array[image_index+1];
    }

    prev() {
        let images = this.data.get("images")
        let images_array = images.split(",")
        let curr_image = document.getElementById("img").src;
        let image_src = curr_image.substring(curr_image.indexOf('/uploads'));
        let image_index = images_array.indexOf(image_src)

        // In case the array is finished go to the last image
        if (image_index-1 < 0) {
            image_index = images_array.length
        }

        document.getElementById("img").src=images_array[image_index-1];
    }
}