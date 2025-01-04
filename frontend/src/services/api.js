const API_URL = 'http://0.0.0.0:5000';

export const fetchResources = async () => {
  try {
    const response = await fetch(`${API_URL}/api/minikube-resources`);
    console.log('Response:', response); // Add this line
    if (!response.ok) throw new Error('Network response was not ok');
    const data = await response.json();
    console.log('Data:', data); // Add this line
    return data;
  } catch (error) {
    console.error('Error:', error); // Add this line
    throw new Error(`Failed to fetch resources: ${error.message}`);
  }
};