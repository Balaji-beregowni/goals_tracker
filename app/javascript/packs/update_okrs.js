document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.update-okrs-form').forEach(function(form) {
    form.addEventListener('submit', function(event) {
      event.preventDefault(); // Prevent default form submission

      // Retrieve form data
      var formData = new FormData(this);

      // Extract goal ID from form action attribute
      var action = this.getAttribute('action');
      var goalId = action.split('/').pop();

      // Make AJAX request to API endpoint with goal ID included
      fetch('https://localhost:3000/' + goalId + '/update_okrs', {
        method: 'POST',
        body: formData
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => {
        // Handle successful response from the API
        console.log('API response:', data);
        // Optionally, perform any UI updates or redirect to another page
      })
      .catch(error => {
        // Handle error response from the API
        console.error('API error:', error);
        // Optionally, display an error message to the user
      });
    });
  });
});
