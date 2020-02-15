import React from "react";
import { InertiaLink } from "@inertiajs/inertia-react";
import Layout from "@/Layouts/Main";

const About = ({ hello }) => {
  return (
    <>
      <h2>About</h2>
      Hello, {hello}
    </>
  );
};
About.layout = page => <Layout children={page} title="Welcome" />;

export default About;
