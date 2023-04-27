'use strict';

/** @type Egg.EggPlugin */
exports.sequelize = {
  enable: true,
  package: 'egg-sequelize',
};
exports.validate = {
  enable: true,
  package: 'egg-validate',
};
exports.mysql = {
  enable: true,
  package: 'egg-mysql',
};
exports.cors = {
  enable: true,
  package: 'egg-cors',
};