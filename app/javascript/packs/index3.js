$(document).ready(function(){

  const FIRST_MONTH = 0;

  render_chart(FIRST_MONTH);

  $('select').on('change', function(e) {        
    var current_month = this.value;
    console.log(current_month);
    render_chart(current_month);
  });  

  function render_chart(val) {
    
    fetch(`index3_data?a=${val}`)
      .then((response) => {
        return response.json();
      })
      .then((response) => {
        var data = response;    

      var ctx = document.getElementById('myChart').getContext('2d');
        var myChart = new Chart(ctx, {
          type: 'bar',
          data: {
            labels: data['month'],
            datasets: [{
              label: 'Quantity sales',
              data: data['data'],              
              borderWidth: 3
            }]
          }
        });
      });
  }
})
