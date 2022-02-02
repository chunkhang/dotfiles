const updateState = (event, previousState) => {
  const { output } = event;

  const newState = {
    ...previousState,
    error: null,
  };

  if (output) {
    try {
      Object.assign(newState, JSON.parse(output));
    } catch (e) {
      newState.error = 'Invalid output';
    }
  } else {
    newState.error = 'No output';
  }

  return newState;
};

export default updateState;
