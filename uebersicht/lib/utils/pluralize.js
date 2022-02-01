const pluralize = (word, quantity) => {
  let string = `${quantity} ${word}`;
  if (quantity > 1) {
    string += 's';
  }
  return string;
};

export default pluralize;
