import Duration from 'duration-js';

const duration = (string) => new Duration(string).milliseconds();

export default duration;
