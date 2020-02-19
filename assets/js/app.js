import "../css/app.css";
import "phoenix_html";
import React from "react";
import { render } from "react-dom";
import { InertiaApp } from "@inertiajs/inertia-react";
import axios from "axios";
axios.defaults.xsrfHeaderName = "x-csrf-token";

const app = document.getElementById("app");

render(
  <InertiaApp
    initialPage={JSON.parse(app.dataset.page)}
    resolveComponent={name =>
      import(`@/Pages/${name}`).then(module => module.default)
    }
  />,
  app
);
