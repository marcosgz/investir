const Chart = require("chart.js");

const MainChart = {
  mounted() {
    console.log('mounted', this.el)

    let stocks = JSON.parse(this.el.dataset.stocks)

    var ctx = document.getElementById('main-chart-wrapper').getContext('2d');
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
        datasets: [{
          label: 'Dataset',
          backgroundColor: 'rgb(255, 99, 132)',
          borderColor: 'rgb(255, 99, 132)',
          data: stocks
        }]
      },
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
