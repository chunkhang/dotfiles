const updateState = (event, previousState) => {
  const { output } = event;

  const data = {
    ...previousState.data,
    error: null,
  };

  if (output) {
    try {
      Object.assign(data, JSON.parse(output));
    } catch (error) {
      data.error = error.toString();
    }
  } else {
    data.error = 'No output found';
  }

  return { data };
};

export default updateState;
