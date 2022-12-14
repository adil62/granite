import React, { useState } from "react";

import Form from "./Form";

import tasksApi from "../../apis/tasks";
import Container from "../Container";

const Create = ({ history }) => {
  const [title, setTitle] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async event => {
    event.preventDefault();
    setLoading(true);
    try {
      await tasksApi.create({ task: { title } });
      setLoading(false);
      history.push("/dashboard");
    } catch (error) {
      logger.error(error);
      setLoading(false);
    }
  };

  return (
    <Container>
      <Form handleSubmit={handleSubmit} loading={loading} setTitle={setTitle} />
    </Container>
  );
};

export default Create;
