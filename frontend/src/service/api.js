import axios from 'axios'

const api = axios.create({
    baseURL: 'http://localhost:8080',
    timeout: 10000,
    headers: {
        'Content-Type': 'application/json',
    }
});

api.interceptors.request.use(
  (config) => {
      const token = localStorage.getItem("Authorization");

      if (token) {
          config.headers = config.headers || {};
          config.headers.Authorization = `${token}`;
      }

      return config;
  },
  (error) => Promise.reject(error)
);

export default api;

