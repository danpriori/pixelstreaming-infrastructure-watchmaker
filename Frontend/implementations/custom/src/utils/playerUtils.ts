export const requestServerAvailable = async (playerUserType: string): Promise<any> => {

    try {
      const response = await fetch(
        `${window.location.protocol}//${window.location.hostname}/serverAvailable?PlayerUserType=${playerUserType}`,
        {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
          },
        }
      );
      return response.json();
    } catch (e) {
      return null;
    }
    // local test
    // return { url: 'localhost:999' };
};