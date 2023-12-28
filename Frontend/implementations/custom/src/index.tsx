import { createRoot } from 'react-dom/client';
import { App } from './components/App';

document.body.onload = function () {
    createRoot(document.body).render(<App />);
};
