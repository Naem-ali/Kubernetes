import React from 'react';
import './NavBar.css';

function NavBar() {
  return (
    <nav className="navbar">
      <div className="navbar-logo">Minikube Dashboard</div>
      <ul className="navbar-links">
        <li><a href="#dashboard">Dashboard</a></li>
        <li><a href="#resources">Resources</a></li>
      </ul>
    </nav>
  );
}

export default NavBar;