import css from "../css/app.css";
import "phoenix_html";
import React from "react";
import { render } from "react-dom";
import { InertiaApp } from "@inertiajs/inertia-react";
import axios from "axios";

axios.interceptors.request.use(function(config) {
  const token = document
    .querySelector("meta[name='csrf-token']")
    .getAttribute("content");
  config.headers["x-csrf-token"] = token;
  return config;
});

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
