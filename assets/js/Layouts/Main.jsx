import React from "react";
import { InertiaLink } from "@inertiajs/inertia-react";

const Main = ({ title, children }) => {
  return (
    <main>
      <header>
        <InertiaLink href="/">Home</InertiaLink>
        <InertiaLink href="/about">About</InertiaLink>
      </header>
      <article>{children}</article>
    </main>
  );
};

export default Main;
