import React, { useEffect, useState } from 'react';
import './ClusterResources.css';
import { fetchPods } from '../api';

function ClusterResources() {
  const [resources, setResources] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchPods()
      .then(data => {
        setResources(data);
        setLoading(false);
      })
      .catch(error => {
        setError(error);
        setLoading(false);
      });
  }, []);

  if (loading) {
    return <div>Loading...</div>;
  }

  if (error) {
    return <div>Error: {error.message}</div>;
  }

  return (
    <div className="cluster-resources">
      {resources.map(resource => (
        <div key={resource.name} className="pod-block">
          <h3>{resource.name}</h3>
          <p><strong>Namespace:</strong> {resource.namespace}</p>
          <p><strong>Status:</strong> {resource.status}</p>
          <p><strong>Node:</strong> {resource.node}</p>
          <p><strong>Start Time:</strong> {resource.start_time}</p>
        </div>
      ))}
    </div>
  );
}

export default ClusterResources;