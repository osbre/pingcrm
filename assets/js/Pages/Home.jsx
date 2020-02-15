import React from "react";
import { InertiaLink } from "@inertiajs/inertia-react";
import Layout from "@/Layouts/Main";

const Home = ({ hello }) => {
  return (
    <>
      <h2>Home</h2>
      Hello, {hello}
    </>
  );
};
Home.layout = page => <Layout children={page} title="Welcome" />;

export default Home;
