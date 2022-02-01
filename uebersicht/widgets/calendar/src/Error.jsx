function Error({ data }) {
  const { error } = data;

  if (!error) return null;

  return <div>{error}</div>;
}

export default Error;
