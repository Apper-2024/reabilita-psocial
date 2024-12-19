const functions = require("firebase-functions");
const axios = require("axios");

const GOOGLE_MAPS_API_KEY = "AIzaSyAoSesmAI2cUK5YF4PWUXJOc_TjhdhA7o4";

/**
 * Função para buscar coordenadas a partir de um endereço
 * @param {string} address - O endereço para buscar as coordenadas
 * @return {Promise<{lat: number, lng: number}>} - As coordenadas do endereço
 */
async function getCoordinates(address) {
  const url = `https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(address)}&key=${GOOGLE_MAPS_API_KEY}`;
  console.log(`Requisição para Geocoding API: ${url}`); // Log da URL gerada
  const response = await axios.get(url);

  console.log("Resposta da Geocoding API:", response.data); // Log do corpo da resposta

  if (response.data.status === "OK" && response.data.results.length > 0) {
    const location = response.data.results[0].geometry.location;
    console.log("Coordenadas obtidas:", location); // Log das coordenadas obtidas
    return { lat: location.lat, lng: location.lng };
  } else {
    console.error("Erro na Geocoding API:", response.data); // Log detalhado do erro
    throw new Error(
      `Falha ao obter coordenadas. Status: ${response.data.status}, Mensagem: ${response.data.error_message || "Nenhuma mensagem de erro"}`
    );
  }
}

/**
 * Função para buscar lugares próximos
 * @param {number} lat - A latitude do local
 * @param {number} lng - A longitude do local
 * @return {Promise<Array>} - Uma lista de lugares próximos
 */
async function getNearbyPlaces(lat, lng) {
  const url = `https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat},${lng}&radius=1500&type=health&keyword=mental&key=${GOOGLE_MAPS_API_KEY}`;
  console.log(`Requisição para Places API: ${url}`); // Log da URL gerada
  const response = await axios.get(url);

  console.log("Resposta da Places API:", response.data); // Log do corpo da resposta

  if (response.data.status === "OK") {
    console.log("Lugares próximos obtidos:", response.data.results); // Log dos resultados obtidos
    return response.data.results;
  } else {
    console.error("Erro na Places API:", response.data); // Log detalhado do erro
    throw new Error(
      `Falha ao obter lugares próximos. Status: ${response.data.status}, Mensagem: ${response.data.error_message || "Nenhuma mensagem de erro"}`
    );
  }
}

// Cloud Function HTTP
exports.searchNearbyPlaces = functions.https.onRequest(async (req, res) => {
  try {
    const address = req.query.address;
    if (!address) {
      console.warn("Parâmetro 'address' ausente na requisição."); // Log de ausência de parâmetro
      res.status(400).send({ error: "O parâmetro 'address' é obrigatório." });
      return;
    }

    console.log("Endereço recebido:", address); // Log do endereço recebido

    const coordinates = await getCoordinates(address);
    console.log("Coordenadas finais:", coordinates); // Log das coordenadas finais

    const places = await getNearbyPlaces(coordinates.lat, coordinates.lng);
    console.log("Lugares próximos encontrados:", places.length); // Log do número de lugares encontrados

    res.status(200).send(places);
  } catch (error) {
    console.error("Erro na execução da função:", error); // Log detalhado do erro
    res.status(500).send({ error: error.message });
  }
});
