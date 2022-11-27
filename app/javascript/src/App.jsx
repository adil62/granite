import React, { useEffect, useState } from "react";

import { Route, Switch, BrowserRouter as Router } from "react-router-dom";

import { setAuthHeaders } from "./apis/axios";
import { initializeLogger } from "./common/logger";
import Dashboard from "./components/Dashboard";
import CreateTask from "./components/Tasks/Create";

const App = () => {
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    initializeLogger();
    setAuthHeaders(setLoading);
  }, []);

  if (loading) {
    return <h1>Loading...</h1>;
  }

  return (
    <Router>
      <Switch>
        <Route exact path="/" render={() => <div>Home</div>} />
        <Route exact path="/about" render={() => <div>About</div>} />
        <Route exact component={Dashboard} path="/dashboard" />
        <Route exact component={CreateTask} path="/tasks/create" />
      </Switch>
    </Router>
  );
};

export default App;
