import React from 'react';
import NavBar from './components/NavBar';
import ClusterResources from './components/ClusterResources';
import './App.css';

function App() {
  return (
    <div className="App">
      <NavBar />
      <header className="App-header">
        <h1>Welcome to the Minikube Dashboard</h1>
      </header>
      <section id="dashboard" className="dashboard">
        <div className="dashboard-block">
          <h2>Cluster Resources</h2>
          <ClusterResources />
        </div>
      </section>
    </div>
  );
}

export default App;