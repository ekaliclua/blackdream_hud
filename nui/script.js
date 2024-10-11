var app = new Vue({
  el: '#app',
  data: {
    showed: true,
    job: 'Chargement...',
    organisation: 'Chargement...',
    money: '0',
    health: 20,
    armor: 100,
    hunger: 100,
    thirst: 100,
    talking: false,
    pId: 0,
    uId: 0
  },

  watch: {
    health: function(val) {
      this.setProgress(this.$refs.health, val);
    },
    armor: function(val) {
      this.setProgress(this.$refs.armor, val);
    },
    hunger: function(val) {
      this.setProgress(this.$refs.hunger, val);
    },
    thirst: function(val) {
      this.setProgress(this.$refs.thirst, val);
    }
  },

  methods: {
    setProgress(element, percent) {
      const Circumference = element.r.baseVal.value * 2 * Math.PI;
      const Offset = Circumference - (percent / 100) * Circumference;
  
      element.style.strokeDasharray = `${Circumference} ${Circumference}`;
      element.style.strokeDashoffset = Offset;
    },
    lerp(start, end, amount) {
      return start + (end - start) * amount;
    },
  },

  created() {
    fetch(`https://${GetParentResourceName()}/hudStarted`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: JSON.stringify({})
    });

    window.addEventListener('message', (event) => {
      if (event.data.type === "hud") {
        this.showed = event.data.enable;
      }

      if (event.data.type === "updateInfo") {
        for (var key in event.data.infos) {
          this[key] = event.data.infos[key];
        }
      }
    });
  }
});
