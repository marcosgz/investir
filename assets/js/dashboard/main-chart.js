const Chart = require("chart.js");

const MainChart = {
  mounted() {
    console.log('mounted', this.el)

    var ctx = document.getElementById('main-chart-wrapper').getContext('2d');
    new Chart(ctx, {
      // The type of chart we want to create
      type: 'line',
      // The data for our dataset
      data: {
          labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
          datasets: [{
              label: 'Dataset',
              backgroundColor: 'rgb(255, 99, 132)',
              borderColor: 'rgb(255, 99, 132)',
              data: [0, 10, 5, 2, 20, 30, 45]
          }]
      },
      // Configuration options go here
      options: {}
    });

  },

  destroyed() {
    // console.log('destroyed')
  },

  updated() {
    // console.log('updates')
  },
};

export default MainChart;
