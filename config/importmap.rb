# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin 'flatpickr' # @4.6.13
pin "stimulus-chartjs", to: "https://ga.jspm.io/npm:stimulus-chartjs@5.0.0/dist/stimulus-chartjs.mjs"
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.1/dist/stimulus.js"
pin "@kurkle/color", to: "https://ga.jspm.io/npm:@kurkle/color@0.3.2/dist/color.esm.js"
pin "chart.js/auto", to: "https://ga.jspm.io/npm:chart.js@4.2.0/auto/auto.js"
