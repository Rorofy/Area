const { Router } = require('express');
const Area = require('../../persistence/areas');
const router = new Router();

router.post('/create', async (request, response) => {
  try {
    const { action, reaction, action_config, reaction_config, user } = request.body;
    if (!action || !reaction) {
      return response
        .status(400)
        .json({ message: 'Action or reaction missing' });
    }
    const area = await Area.create(action, reaction, action_config, reaction_config, user.id);
    return response.status(200).json({
      message: 'Area created'
    });
  } catch (error) {
    console.error(
      `createArea({ action: ${request.body.action}, reaction: ${request.body.reaction} }) >> Error: ${error.stack}`
    );
    response.status(500).json();
  }
});

router.get('/getAll', async (request, response) => {
  try {
    const { user } = request.body
    const areas = await Area.findAll(user.id)
    response.status(200).json({
      message: 'Areas sent',
      areas
    })
  } catch (error) {
    console.error(
      `getAllAreas() >> Error: ${error.stack}`
    );
    response.status(500).json();
  }
});

router.delete('/delete/:id', async (req, res) => {
  try {
    const area = await Area.find(req.params.id)
    if (area.user_id !== req.body.user.id) {
      res.status(403).json({
        message: "That's not your area !"
      })
      return
    }
    await Area.delete(req.params.id)
    res.status(200).json({
      message: "Area deleted"
    })
  } catch (error) {
    console.error(
      `deleteArea(${req.params.id}) >> Error: ${error.stack}`
    );
  }
})

router.patch('/update/:id', async (req, res) => {
  try {
    const { key, value } = req.body
    const area = await Area.find(req.params.id)
    if (area.user_id !== req.body.user.id) {
      res.status(403).json({
        message: "That's not your area !"
      })
      return
    }
    await Area.update(req.params.id, key, value)
    res.status(200).json({
      message: `Area updated`,
      area: {
        id: req.params.id,
        [key]: value
      }
    })
  } catch (e) {

  }
})
module.exports = router;