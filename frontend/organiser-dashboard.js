  document.getElementById('create-event').addEventListener('submit', async (e) => {
    e.preventDefault();

    const form = e.target;
    const formData = new FormData(form);

    const payload = {
      name: formData.get('name'),
      location: formData.get('location'),
      event_date: new Date(formData.get('date')).toISOString(), // Converts datetime-local to ISO
      category: formData.get('category'),
      description: formData.get('description'),
      ticket_total: parseInt(formData.get('ticket_total'), 10)
    };

    try {
      const res = await fetch('/api/createEvent', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
      });

      const result = await res.json();
      document.getElementById('result').textContent = result.success
        ? 'Event created!'
        : `Failed to create event: ${result.error}`;
    } catch (err) {
      document.getElementById('result').textContent = 'Something went wrong.';
      console.error(err);
    }
  });