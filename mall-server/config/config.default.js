/* eslint valid-jsdoc: "off" */

'use strict';

/**
 * @param {Egg.EggAppInfo} appInfo app info
 */
module.exports = appInfo => {
  /**
   * built-in config
   * @type {Egg.EggAppConfig}
   **/
  const config = exports = {};

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_1614090648623_2061';
  config.jwtSecret = '000000';
  config.middleware = ['ratelimit', 'error'];
  config.serverTimeout = 10 * 60 * 1000;
  config.security = {
    domainWhiteList: ['*'],
    csrf: {
      enable: false
    }
  };
  // add your middleware config here
  config.sequelize = {
    dialect: 'mysql',
    database: 'mall',
    host: 'localhost',
    port: '3306',
    username: 'root',
    password: '123456',
    logging: false
  };
  config.static = {
    prefix: ''
  };
  config.cors = {
    origin:'*',
    allowMethods: 'GET,HEAD,PUT,POST,DELETE,PATCH'
  };

  return {
    ...config
  };
};
