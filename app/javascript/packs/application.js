// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery"
import "popper.js"
import "bootstrap"
import "../stylesheets/application"
import 'cocoon'

// import { fas } from '@fortawesome/free-solid-svg-icons'
// import { far } from '@fortawesome/free-regular-svg-icons'
// import { fab } from '@fortawesome/free-brands-svg-icons'
// import { library } from "@fortawesome/fontawesome-svg-core";
// import '@fortawesome/fontawesome-free'
// library.add(fas, far, fab)

Rails.start()
Turbolinks.start()
ActiveStorage.start()
