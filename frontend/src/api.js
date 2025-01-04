const API_URL = 'http://192.168.0.5:3000';

export const fetchPods = async () => {
  try {
    const response = await fetch(`${API_URL}/api/pods`);
    if (!response.ok) throw new Error('Network response was not ok');
    const data = await response.json();
    return data;
  } catch (error) {
    throw new Error(`Failed to fetch pods: ${error.message}`);
  }
};