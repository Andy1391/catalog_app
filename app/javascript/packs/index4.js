fetch('index4_data')
  .then((response) => {
    return response.json();
  })
  .then((response) => {
    var data = response;    

var ctx = document.getElementById('myChart').getContext('2d');
  var myChart = new Chart(ctx, {
      type: 'line',
      data: {
          labels: data['months'],
          datasets: [{
              label: 'Quantity sales',
              data: data['data'],
              borderColor: [
                  'rgba(58, 153, 83, 1)'                
              ],
              borderWidth: 3
          }]
      }});

  });