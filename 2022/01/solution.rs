// Learning rust by following Brent Westbrook's youtube walkthrough
// https://github.com/ntBre/advent22

const INPUT_PATH: &str = "./01/data.txt";

fn load_input() -> String {
  std::fs::read_to_string(INPUT_PATH).unwrap()
}

fn max_calories(input: &String) -> usize {
  *elves(input).iter().max().unwrap()
}

fn top_max_calories(input: &String, num: usize) -> usize {
  let mut elves = elves(input);
  elves.sort();
  elves.reverse();
  elves[..num].iter().sum()
}

fn elves(input: &String) -> Vec<usize> {
  let mut elves = Vec::new();
  let mut sum = 0;

  for line in input.lines() {
    if line.is_empty() {
      elves.push(sum);
      sum = 0;
    } else {
      sum += line.parse::<usize>().unwrap();
    }
  }
  elves.push(sum);
  elves
}

fn main() {
  let input = load_input();

  let max = max_calories(&input);
  let max_3 = top_max_calories(&input, 3);

  println!("max cal is {max}");
  println!("top 3 max cal is {max_3}");
}
