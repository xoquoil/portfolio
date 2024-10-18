// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';

require("jquery")
require("@nathanvda/cocoon")

Rails.start()
ActiveStorage.start()



document.addEventListener("DOMContentLoaded", function() {
    document.querySelectorAll('.add_fields').forEach(function(link) {
      link.addEventListener('click', function(event) {
        event.preventDefault();
        let time = new Date().getTime();
        let linkId = time;
        let fields = link.getAttribute('data-fields').replace(/new_\w+/g, linkId);
        document.querySelector('#pins').insertAdjacentHTML('beforeend', fields);
      });
    });
  });
